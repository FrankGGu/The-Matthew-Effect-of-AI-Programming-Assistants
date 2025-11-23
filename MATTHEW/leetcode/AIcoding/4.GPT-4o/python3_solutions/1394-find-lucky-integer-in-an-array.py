class Solution:
    def findLucky(self, arr: List[int]) -> int:
        count = Counter(arr)
        lucky = -1
        for num in count:
            if num == count[num]:
                lucky = max(lucky, num)
        return lucky