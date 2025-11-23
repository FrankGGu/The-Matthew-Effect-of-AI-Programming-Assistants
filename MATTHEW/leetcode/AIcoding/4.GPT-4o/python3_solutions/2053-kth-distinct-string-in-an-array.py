class Solution:
    def kthDistinct(self, arr: List[str], k: int) -> str:
        count = {}
        for s in arr:
            count[s] = count.get(s, 0) + 1
        distinct_count = 0
        for s in arr:
            if count[s] == 1:
                distinct_count += 1
                if distinct_count == k:
                    return s
        return ""