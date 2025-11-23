class Solution:
    def duplicateZeros(self, arr: list[int]) -> None:
        n = len(arr)

        slow = 0
        fast = 0

        while slow < n:
            if arr[slow] == 0:
                fast += 2
            else:
                fast += 1

            if fast >= n:
                break

            slow += 1

        write_ptr = n - 1

        if fast == n + 1:
            arr[write_ptr] = 0
            write_ptr -= 1
            slow -= 1

        while slow >= 0:
            if arr[slow] == 0:
                arr[write_ptr] = 0
                write_ptr -= 1
                arr[write_ptr] = 0
            else:
                arr[write_ptr] = arr[slow]

            write_ptr -= 1
            slow -= 1