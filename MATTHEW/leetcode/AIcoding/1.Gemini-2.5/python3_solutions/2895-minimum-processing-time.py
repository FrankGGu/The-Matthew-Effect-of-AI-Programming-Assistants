class Solution:
    def minProcessingTime(self, processorTime: list[int], tasks: list[int]) -> int:
        processorTime.sort()
        tasks.sort(reverse=True)

        n_processors = len(processorTime)

        k_tasks_per_processor = len(tasks) // n_processors

        min_max_completion_time = 0

        for i in range(n_processors):
            # The i-th fastest processor (processorTime[i]) is assigned a block of k_tasks_per_processor tasks.
            # To minimize the overall maximum completion time, we pair the fastest processors
            # with the tasks that have the largest maximum values within their respective blocks.
            #
            # Since tasks are sorted in descending order, the largest task in the block
            # assigned to processor 'i' will be tasks[i * k_tasks_per_processor].
            #
            # Example:
            # processorTime = [p0, p1, p2, ...] (sorted ascending)
            # tasks = [t0, t1, t2, t3, t4, t5, ...] (sorted descending)
            # k = k_tasks_per_processor
            #
            # Processor p0 gets tasks [t0, t1, ..., t(k-1)]. Max task time is t0. Completion: p0 + t0.
            # Processor p1 gets tasks [tk, t(k+1), ..., t(2k-1)]. Max task time is tk. Completion: p1 + tk.
            # And so on.
            # Processor pi gets tasks [t(i*k), ..., t((i+1)*k-1)]. Max task time is t(i*k). Completion: pi + t(i*k).

            current_processor_completion_time = processorTime[i] + tasks[i * k_tasks_per_processor]
            min_max_completion_time = max(min_max_completion_time, current_processor_completion_time)

        return min_max_completion_time