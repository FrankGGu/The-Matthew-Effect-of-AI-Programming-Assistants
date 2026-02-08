def minimumPerimeter(apples: int) -> int:
    return (2 * ((int((apples / 4) ** 0.5) + 1) * 2)) if apples > 0 else 0