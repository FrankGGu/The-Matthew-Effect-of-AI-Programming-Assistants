class Solution:
    def categorizeBox(self, length: int, width: int, height: int) -> str:
        isHeavy = length * width * height >= 10**9
        isBulky = max(length, width, height) >= 10**4 or (length * width * height >= 10**9)
        if isBulky and isHeavy:
            return "Both"
        elif isBulky:
            return "Bulky"
        elif isHeavy:
            return "Heavy"
        else:
            return "Neither"