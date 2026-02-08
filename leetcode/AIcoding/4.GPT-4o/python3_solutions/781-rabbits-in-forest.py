def numRabbits(answers):
    from collections import Counter
    count = Counter(answers)
    total = 0
    for answer, freq in count.items():
        total += (answer + 1) * ((freq + answer) // (answer + 1))
    return total