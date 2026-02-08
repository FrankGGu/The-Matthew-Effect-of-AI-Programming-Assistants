class Solution:
    def categorizeBox(self, length: int, width: int, height: int, mass: int) -> str:
        is_bulky = False
        is_heavy = False

        # Check for Bulky
        if length >= 10000 or width >= 10000 or height >= 10000:
            is_bulky = True

        volume = length * width * height
        if volume >= 1000000000:
            is_bulky = True

        # Check for Heavy
        if mass >= 100:
            is_heavy = True

        # Determine category
        if is_bulky and is_heavy:
            return "Both"
        elif is_bulky:
            return "Bulky"
        elif is_heavy:
            return "Heavy"
        else:
            return "Neither"