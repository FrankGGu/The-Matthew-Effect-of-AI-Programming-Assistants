class Solution:
    def largestMultipleOfThree(self, digits: List[int]) -> str:
        count = [0] * 10
        for d in digits:
            count[d] += 1

        total = sum(digits)
        if total % 3 == 0:
            return ''.join(str(i) * count[i] for i in range(9, -1, -1)) or "0"

        def remove_one(mod):
            for i in range(mod, 10, 3):
                if count[i] > 0:
                    count[i] -= 1
                    return True
            return False

        if not remove_one(total % 3):
            if not remove_one((total + 1) % 3):
                return ""

        result = ''.join(str(i) * count[i] for i in range(9, -1, -1))
        return result or "0"