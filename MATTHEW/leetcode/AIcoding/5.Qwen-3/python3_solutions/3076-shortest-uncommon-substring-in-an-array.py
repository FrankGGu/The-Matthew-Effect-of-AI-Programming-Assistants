class Solution:
    def shortestUncommonSubstring(self, s: List[str]) -> str:
        from collections import defaultdict

        def get_substrings(word):
            n = len(word)
            substrings = set()
            for i in range(n):
                for j in range(i + 1, n + 1):
                    substrings.add(word[i:j])
            return substrings

        all_substrings = defaultdict(int)
        for word in s:
            subs = get_substrings(word)
            for sub in subs:
                all_substrings[sub] += 1

        result = ""
        min_len = float('inf')
        for word in s:
            subs = get_substrings(word)
            for sub in subs:
                if all_substrings[sub] == 1:
                    if len(sub) < min_len:
                        min_len = len(sub)
                        result = sub
        return result