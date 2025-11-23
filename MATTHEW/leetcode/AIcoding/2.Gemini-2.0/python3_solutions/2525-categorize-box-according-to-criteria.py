class Solution:
    def categorizeBox(self, length: int, width: int, height: int, mass: int) -> str:
        vol = length * width * height
        bulky = False
        heavy = False

        if length >= 10000 or width >= 10000 or height >= 10000 or vol >= 1000000000:
            bulky = True

        if mass >= 100:
            heavy = True

        if bulky and heavy:
            return "Both"
        elif bulky:
            return "Bulky"
        elif heavy:
            return "Heavy"
        else:
            return "Neither"