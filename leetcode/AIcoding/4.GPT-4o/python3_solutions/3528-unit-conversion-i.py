class Solution:
    def convert(self, num: float, fromUnit: str, toUnit: str) -> float:
        conversion = {
            "inch": 0.0254,
            "foot": 0.3048,
            "yard": 0.9144,
            "mile": 1609.34,
            "millimeter": 0.001,
            "centimeter": 0.01,
            "meter": 1,
            "kilometer": 1000,
            "milligram": 1e-6,
            "gram": 0.001,
            "kilogram": 1,
            "ton": 1000,
            "ounce": 0.0283495,
            "pound": 0.453592,
            "stone": 6.35029,
            "us_gallon": 3.78541,
            "liter": 0.001,
            "quart": 0.946353,
            "pint": 0.473176,
            "cup": 0.236588,
            "fluid_ounce": 0.0295735,
        }

        return num * conversion[fromUnit] / conversion[toUnit]