class Solution:
    def maximumNumber(self, num: str, change: List[List[int]]) -> str:
        num = list(num)
        changed = False

        for i in range(len(num)):
            digit = int(num[i])
            if digit < change[digit][1]:
                num[i] = str(change[digit][1])
                changed = True
            elif digit > change[digit][0] and changed:
                break

        return ''.join(num)