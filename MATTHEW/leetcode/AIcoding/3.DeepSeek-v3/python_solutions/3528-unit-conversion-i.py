class Solution:
    def convert(self, numerator: int, denominator: int, fromUnit: str, toUnit: str) -> float:
        units = {
            'in': 1,
            'ft': 12,
            'yd': 36,
            'mi': 63360,
            'mm': 1/25.4,
            'cm': 1/2.54,
            'm': 1/0.0254,
            'km': 1/0.0000254
        }

        if fromUnit not in units or toUnit not in units:
            return -1.0

        value_in_inches = (numerator / denominator) * units[fromUnit]
        result = value_in_inches / units[toUnit]

        return result