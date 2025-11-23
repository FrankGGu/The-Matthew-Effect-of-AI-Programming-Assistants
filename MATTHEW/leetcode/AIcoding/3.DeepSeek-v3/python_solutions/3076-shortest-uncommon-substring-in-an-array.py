class Solution:
    def shortestUncommonSubstring(self, arr: List[str]) -> List[str]:
        from collections import defaultdict

        n = len(arr)
        result = [""] * n
        substr_map = defaultdict(list)

        for i in range(n):
            s = arr[i]
            m = len(s)
            unique_substrings = set()
            for l in range(1, m + 1):
                for j in range(m - l + 1):
                    substr = s[j:j+l]
                    unique_substrings.add(substr)
            for substr in unique_substrings:
                substr_map[substr].append(i)

        for substr in substr_map:
            if len(substr_map[substr]) == 1:
                idx = substr_map[substr][0]
                if result[idx] == "" or len(substr) < len(result[idx]):
                    result[idx] = substr

        return result