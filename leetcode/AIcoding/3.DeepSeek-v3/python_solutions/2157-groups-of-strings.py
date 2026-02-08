class Solution:
    def groupStrings(self, strings: List[str]) -> List[List[str]]:
        groups = {}
        for s in strings:
            key = []
            for i in range(1, len(s)):
                diff = (ord(s[i]) - ord(s[i-1])) % 26
                key.append(str(diff))
            pattern = ','.join(key)
            if pattern not in groups:
                groups[pattern] = []
            groups[pattern].append(s)
        return list(groups.values())