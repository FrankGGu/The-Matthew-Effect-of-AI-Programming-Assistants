import random

def rand7():
    return random.randint(1, 7)

def rand10():
    while True:
        row = rand7() - 1
        col = rand7() - 1
        idx = row * 7 + col  # Now idx in range [0, 48)
        if idx < 40:  # We can only use [0, 39] to map to [1, 10]
            return idx % 10 + 1