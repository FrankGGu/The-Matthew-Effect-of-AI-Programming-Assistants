def minFoodBuckets(hamsters: int, buckets: int) -> int:
    if buckets < hamsters:
        return -1
    return (hamsters + 1) // 2 + (buckets - hamsters)