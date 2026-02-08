from typing import List
import heapq

def topKStudents(score: List[int], k: int) -> List[int]:
    return [x[1] for x in heapq.nlargest(k, enumerate(score), key=lambda x: x[1])]