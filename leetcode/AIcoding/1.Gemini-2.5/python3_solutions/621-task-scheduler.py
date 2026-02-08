import collections

class Solution:
    def leastInterval(self, tasks: list[str], n: int) -> int:
        task_counts = collections.Counter(tasks)

        max_freq = 0
        for count in task_counts.values():
            if count > max_freq:
                max_freq = count

        num_max_freq_tasks = 0
        for count in task_counts.values():
            if count == max_freq:
                num_max_freq_tasks += 1

        time_based_on_pattern = (max_freq - 1) * (n + 1) + num_max_freq_tasks

        return max(len(tasks), time_based_on_pattern)