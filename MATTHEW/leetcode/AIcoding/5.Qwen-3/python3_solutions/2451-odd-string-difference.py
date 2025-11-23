class Solution:
    def oddString(self, data: List[str]) -> str:
        def get_diff(s):
            return [ord(s[i]) - ord(s[i-1]) for i in range(1, len(s))]

        diff_map = {}
        for s in data:
            diff = tuple(get_diff(s))
            if diff in diff_map:
                diff_map[diff].append(s)
            else:
                diff_map[diff] = [s]

        for v in diff_map.values():
            if len(v) == 1:
                return v[0]