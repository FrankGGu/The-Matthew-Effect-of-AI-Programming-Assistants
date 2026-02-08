def maxDepthAfterSplit(seq: str) -> List[int]:
    return [i % 2 for i, char in enumerate(seq) if char == '(']