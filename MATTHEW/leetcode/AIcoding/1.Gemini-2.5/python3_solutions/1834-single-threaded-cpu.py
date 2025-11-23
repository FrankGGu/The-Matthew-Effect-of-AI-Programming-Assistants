import heapq

class Solution:
    def getOrder(self, tasks: list[list[int]]) -> list[int]:
        n = len(tasks)

        # Augment tasks with their original indices: (enqueueTime, processingTime, originalIndex)
        all_tasks = []
        for i in range(n):
            all_tasks.append((tasks[i][0], tasks[i][1], i))

        # Sort tasks primarily by enqueue time
        all_tasks.sort()

        result = []
        available_tasks_heap = [] # Min-heap storing (processingTime, originalIndex)

        current_time = 0
        task_pointer = 0 # Pointer for the sorted all_tasks list

        while len(result) < n:
            # Add all tasks whose enqueueTime <= current_time to the min-heap
            while task_pointer < n and all_tasks[task_pointer][0] <= current_time:
                enqueue_time, processing_time, original_index = all_tasks[task_pointer]
                heapq.heappush(available_tasks_heap, (processing_time, original_index))
                task_pointer += 1

            if available_tasks_heap:
                # If there are tasks available, process the one with the shortest processing time
                # (and smallest index for ties)
                processing_time, original_index = heapq.heappop(available_tasks_heap)
                result.append(original_index)
                current_time += processing_time
            else:
                # If no tasks are available in the heap, the CPU is idle.
                # Advance current_time to the enqueue time of the next task in all_tasks.
                # This only happens if task_pointer < n (there are still tasks not yet enqueued).
                # If task_pointer == n and heap is empty, the loop will terminate.
                if task_pointer < n:
                    current_time = max(current_time, all_tasks[task_pointer][0])
                # else: if task_pointer == n and heap is empty, it means all tasks have been processed
                # or there are no more tasks to enqueue and nothing in heap, so the loop will end.

        return result