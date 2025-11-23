def unit_conversion(value: float, unit: str) -> float:
    if unit == "inches":
        return value * 2.54
    elif unit == "feet":
        return value * 30.48
    elif unit == "yards":
        return value * 91.44
    elif unit == "miles":
        return value * 160934.4
    else:
        return value