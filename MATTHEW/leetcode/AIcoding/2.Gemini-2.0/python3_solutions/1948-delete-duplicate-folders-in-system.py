class Solution:
    def deleteDuplicateFolder(self, paths: list[list[str]]) -> list[list[str]]:
        def build_trie(paths):
            root = {}
            for path in paths:
                curr = root
                for folder in path:
                    if folder not in curr:
                        curr[folder] = {}
                    curr = curr[folder]
            return root

        def get_signature(node, signatures):
            signature = "("
            folders = sorted(node.keys())
            for folder in folders:
                signature += folder
                signature += get_signature(node[folder], signatures)
                signature += ")"
            if signature in signatures:
                signatures[signature].append(node)
            else:
                signatures[signature] = [node]
            return signature

        def mark_duplicates(root, signatures, duplicate_nodes):
            for signature, nodes in signatures.items():
                if len(nodes) > 1:
                    for node in nodes:
                        duplicate_nodes.add(node)

        def delete_duplicates(root, duplicate_nodes):
            def dfs(node, path, result):
                if node not in duplicate_nodes:
                    if path:
                        result.append(path)
                    folders = sorted(node.keys())
                    for folder in folders:
                        dfs(node[folder], path + [folder], result)

            result = []
            dfs(root, [], result)
            return sorted(result)

        root = build_trie(paths)
        signatures = {}
        get_signature(root, signatures)
        duplicate_nodes = set()
        mark_duplicates(root, signatures, duplicate_nodes)
        return delete_duplicates(root, duplicate_nodes)