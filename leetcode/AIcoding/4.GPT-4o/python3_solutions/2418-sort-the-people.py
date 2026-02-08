def sortPeople(names: List[str], heights: List[int]) -> List[str]:
    return [name for name, _ in sorted(zip(names, heights), key=lambda x: x[1], reverse=True)]