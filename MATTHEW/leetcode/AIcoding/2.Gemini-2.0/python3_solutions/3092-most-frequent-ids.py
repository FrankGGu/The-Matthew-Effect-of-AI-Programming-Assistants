from collections import Counter

def mostFrequentIDs(ids):
    """
    Given a list of IDs, find the most frequent ID(s).
    If there are multiple IDs with the same highest frequency, return them in any order.

    Args:
        ids: A list of integers representing IDs.

    Returns:
        A list of the most frequent IDs.
    """
    if not ids:
        return []

    counts = Counter(ids)
    max_count = max(counts.values())

    return [id for id, count in counts.items() if count == max_count]