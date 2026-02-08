class Solution:
    def lastVisitedIntegers(self, words: List[str]) -> List[int]:
        nums = []
        result = []
        k = 0

        for word in words:
            if word == "prev":
                k += 1
                if k <= len(nums):
                    result.append(nums[-k])
                else:
                    result.append(-1)
            else:
                nums.append(int(word))
                k = 0

        return result