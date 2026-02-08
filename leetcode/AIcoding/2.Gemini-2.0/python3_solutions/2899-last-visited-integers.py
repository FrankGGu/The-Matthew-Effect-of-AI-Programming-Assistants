class Solution:
    def lastVisitedIntegers(self, words: list[str]) -> list[int]:
        nums = []
        ans = []
        k = 0
        for word in words:
            if word == "prev":
                k += 1
                if len(nums) < k:
                    ans.append(-1)
                else:
                    ans.append(nums[-k])
            else:
                nums.append(int(word))
                k = 0
        return ans