class Solution:
    def hIndex(self, citations: List[int]) -> int:
        citations.sort(reverse=True)
        h = 0
        for i, citation in enumerate(citations):
            if i < citation:
                h += 1
            else:
                break
        return h