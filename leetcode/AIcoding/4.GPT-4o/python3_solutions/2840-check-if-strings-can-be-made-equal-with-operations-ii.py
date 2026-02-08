def canBeEqual(target: str, arr: List[str]) -> bool:
    return sorted(target) == sorted(arr)