class Solution:
    def largestGoodInteger(self, num: str) -> str:
        ans = ""
        for i in range(len(num) - 2):
            if num[i] == num[i+1] == num[i+2]:
                good_int = num[i] * 3
                if ans == "" or good_int > ans:
                    ans = good_int
        return ans