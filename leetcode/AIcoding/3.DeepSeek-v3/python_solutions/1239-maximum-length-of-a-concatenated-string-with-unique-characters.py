class Solution:
    def maxLength(self, arr: List[str]) -> int:
        max_len = 0
        unique = [set()]

        for s in arr:
            if len(set(s)) != len(s):
                continue
            s_set = set(s)
            for existing in unique[:]:
                if not s_set & existing:
                    new_set = s_set | existing
                    unique.append(new_set)
                    max_len = max(max_len, len(new_set))

        return max_len