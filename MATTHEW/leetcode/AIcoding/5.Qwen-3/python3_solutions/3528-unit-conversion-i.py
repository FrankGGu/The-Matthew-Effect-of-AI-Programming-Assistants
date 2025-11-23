class Solution:
    def convert(self, value: float, input_unit: str, output_unit: str) -> float:
        units = {
            'm': 1.0,
            'cm': 0.01,
            'mm': 0.001,
            'km': 1000.0,
            'in': 0.0254,
            'ft': 0.3048,
            'yd': 0.9144,
            'mi': 1609.34
        }

        return value * units[input_unit] / units[output_unit]