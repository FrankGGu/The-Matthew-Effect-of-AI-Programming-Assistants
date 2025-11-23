def canCompleteTraining(n: int, difficulties: List[int], trainingTime: int) -> bool:
    total_time = sum(difficulties)
    return total_time <= trainingTime