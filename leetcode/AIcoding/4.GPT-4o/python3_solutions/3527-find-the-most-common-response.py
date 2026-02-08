from collections import Counter

def mostCommonResponse(responses):
    counter = Counter(responses)
    return counter.most_common(1)[0][0]