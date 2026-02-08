class Solution:
    def removeBeans(self, beans: list[int]) -> int:
        n = len(beans)
        if n == 0:
            return 0

        beans.sort()

        total_sum = sum(beans)
        min_removed_beans = total_sum  # Initialize with the cost of removing all beans

        for i in range(n):
            # If beans[i] is chosen as the minimum number of beans for all kept bags:
            # All bags beans[0]...beans[i-1] must be removed.
            # All bags beans[i]...beans[n-1] can be kept and reduced to beans[i].

            # The number of bags that would be kept is (n - i).
            # The total number of beans remaining in these kept bags would be (n - i) * beans[i].
            # The total number of beans initially is total_sum.
            # The number of beans removed is total_sum - (beans remaining).

            num_kept_bags = n - i
            beans_kept = num_kept_bags * beans[i]
            current_removed_beans = total_sum - beans_kept

            min_removed_beans = min(min_removed_beans, current_removed_beans)

        return min_removed_beans