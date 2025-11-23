def triangle_type(nums):
    a, b, c = sorted(nums)
    if a + b <= c:
        return "Not A Triangle"
    elif a**2 + b**2 == c**2:
        return "Right"
    elif a**2 + b**2 > c**2:
        return "Acute"
    else:
        return "Obtuse"