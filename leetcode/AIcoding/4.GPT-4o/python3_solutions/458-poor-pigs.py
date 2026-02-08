def poorPigs(buckets: int, minutesToDie: int, minutesToTest: int) -> int:
    tests = minutesToTest // minutesToDie
    return math.ceil(math.log(buckets) / math.log(tests + 1))