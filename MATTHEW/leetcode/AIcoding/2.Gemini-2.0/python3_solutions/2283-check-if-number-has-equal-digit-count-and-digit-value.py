class Solution:
    def digitCount(self, num: str) -> bool:
        for i in range(len(num)):
            count = 0
            for j in range(len(num)):
                if int(num[j]) == i:
                    count += 1
            if count != int(num[i]):
                return False
        return True