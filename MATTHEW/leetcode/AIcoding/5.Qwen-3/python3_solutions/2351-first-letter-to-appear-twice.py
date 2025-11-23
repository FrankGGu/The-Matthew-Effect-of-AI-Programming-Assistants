class Solution:
    def kthDistinct(self, list1: List[str], k: int) -> str:
        from collections import Counter
        count = Counter(list1)
        for item in list1:
            if count[item] == 1:
                k -= 1
                if k == 0:
                    return item
        return ""