class Router:
    def __init__(self):
        self.root = {'children': {}, 'param_child': None, 'handler': None}

    def add_route(self, path: str, handler):
        segments = path.strip('/').split('/')
        if not segments or (len(segments) == 1 and segments[0] == ''):
            segments = []

        current_node = self.root
        for segment in segments:
            if segment.startswith('{') and segment.endswith('}'):
                param_name = segment[1:-1]
                if current_node['param_child'] is None:
                    current_node['param_child'] = {'children': {}, 'param_child': None, 'handler': None, 'param_name': param_name}
                current_node = current_node['param_child']
            else:
                if segment not in current_node['children']:
                    current_node['children'][segment] = {'children': {}, 'param_child': None, 'handler': None}
                current_node = current_node['children'][segment]
        current_node['handler'] = handler

    def match(self, path: str):
        segments = path.strip('/').split('/')
        if not segments or (len(segments) == 1 and segments[0] == ''):
            segments = []

        potential_matches = []

        def _traverse(node, segment_index, current_params, num_static, num_total):
            if segment_index == len(segments):
                if node['handler'] is not None:
                    potential_matches.append((node['handler'], current_params, num_static, num_total))
                return

            segment = segments[segment_index]

            if segment in node['children']:
                _traverse(node['children'][segment], segment_index + 1, current_params, num_static + 1, num_total + 1)

            if node['param_child'] is not None:
                param_name = node['param_child']['param_name']
                new_params = current_params.copy()
                new_params[param_name] = segment
                _traverse(node['param_child'], segment_index + 1, new_params, num_static, num_total + 1)

        _traverse(self.root, 0, {}, 0, 0)

        if not potential_matches:
            return None, {}

        potential_matches.sort(key=lambda x: (x[3], x[2]), reverse=True)

        best_handler, best_params, _, _ = potential_matches[0]
        return best_handler, best_params