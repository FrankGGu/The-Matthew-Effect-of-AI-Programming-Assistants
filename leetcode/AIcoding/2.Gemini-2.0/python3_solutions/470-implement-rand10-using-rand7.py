def rand10():
    """
    :rtype: int
    """
    while True:
        val = (rand7() - 1) * 7 + (rand7() - 1)
        if val < 40:
            return val % 10 + 1