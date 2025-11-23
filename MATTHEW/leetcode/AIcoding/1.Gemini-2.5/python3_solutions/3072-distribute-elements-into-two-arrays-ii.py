class FenwickTree:
    def __init__(self, size):
        self.tree = [0] * (size + 1)
        self.size = size

    def update(self, index, delta):
        index += 1
        while index <= self.size:
            self.tree[index] += delta
            index += index & (-index)

    def query(self, index):
        index += 1
        s = 0
        while index > 0:
            s += self.tree[index]
            index -= index & (-index)
        return s

class Solution:
    def distributeElements(self, nums: list[int]) -> list[int]:
        n = len(nums)

        unique_nums = sorted(list(set(nums)))
        val_to_rank = {val: i for i, val in enumerate(unique_nums)}
        M = len(unique_nums)

        arr1 = [nums[0]]
        arr2 = [nums[1]]

        bit1 = FenwickTree(M)
        bit2 = FenwickTree(M)

        bit1.update(val_to_rank[nums[0]], 1)
        bit2.update(val_to_rank[nums[1]], 1)

        for i in range(2, n):
            current_num = nums[i]
            current_rank = val_to_rank[current_num]

            total_in_arr1 = bit1.query(M - 1)
            le_current_num_in_arr1 = bit1.query(current_rank)
            count1 = total_in_arr1 - le_current_num_in_arr1

            total_in_arr2 = bit2.query(M - 1)
            le_current_num_in_arr2 = bit2.query(current_rank)
            count2 = total_in_arr2 - le_current_num_in_arr2

            if count1 > count2:
                arr1.append(current_num)
                bit1.update(current_rank, 1)
            elif count2 > count1:
                arr2.append(current_num)
                bit2.update(current_rank, 1)
            else:
                if len(arr1) <= len(arr2):
                    arr1.append(current_num)
                    bit1.update(current_rank, 1)
                else:
                    arr2.append(current_num)
                    bit2.update(current_rank, 1)

        return arr1 + arr2