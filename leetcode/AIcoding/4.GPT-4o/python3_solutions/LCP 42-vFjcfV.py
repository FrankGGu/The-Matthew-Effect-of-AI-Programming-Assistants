def numRabbits(answers):
    from collections import Counter
    count = Counter(answers)
    total = 0
    for key in count:
        total += (key + 1) * ((count[key] + key) // (key + 1))
    return total