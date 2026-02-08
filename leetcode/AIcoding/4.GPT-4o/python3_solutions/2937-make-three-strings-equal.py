class Solution:
    def makeEqual(self, strs: List[str]) -> bool:
        total_chars = Counter()
        for s in strs:
            total_chars.update(s)
        return all(count % len(strs) == 0 for count in total_chars.values())