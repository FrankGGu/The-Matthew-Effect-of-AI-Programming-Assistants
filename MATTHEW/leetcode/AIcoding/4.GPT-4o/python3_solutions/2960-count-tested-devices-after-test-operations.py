def countDevices(n: int, operations: List[List[int]]) -> int:
    tested = set()
    for op in operations:
        if op[0] == 1:
            tested.add(op[1])
        else:
            tested.discard(op[1])
    return len(tested)