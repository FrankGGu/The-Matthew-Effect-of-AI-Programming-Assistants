class Solution:
    def categorizeBox(self, length: int, width: int, height: int, mass: int) -> str:
        bulky = False
        heavy = mass >= 100

        volume = length * width * height
        if length >= 10**4 or width >= 10**4 or height >= 10**4 or volume >= 10**9:
            bulky = True

        if bulky and heavy:
            return "Both"
        elif bulky:
            return "Bulky"
        elif heavy:
            return "Heavy"
        else:
            return "Neither"