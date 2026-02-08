from collections import Counter

def minRounds(tasks):
    task_count = Counter(tasks)
    rounds = 0

    for count in task_count.values():
        if count == 1:
            return -1
        rounds += (count + 2) // 3

    return rounds