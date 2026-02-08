class Solution:
    def maximumBeauty(self, flowers: list[int], newFlowers: int, target: int, full: int, partial: int) -> int:
        flowers.sort()
        n = len(flowers)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + flowers[i]

        ans = 0
        for num_full in range(n + 1):
            rem_new_flowers = newFlowers
            if num_full > 0:
                if flowers[n - num_full] < target:
                    need = target - flowers[n - num_full]
                    if rem_new_flowers < need:
                        continue
                    else:
                        rem_new_flowers -= need
                        flowers[n - num_full] = target

            if num_full > 0:
                need_total = num_full * target - (prefix_sum[n] - prefix_sum[n - num_full])
                if rem_new_flowers < need_total:
                    continue
                else:
                    rem_new_flowers -= need_total

            l, r = 0, n - num_full - 1
            best_partial = 0
            while l <= r:
                mid = (l + r) // 2
                need = (mid + 1) * target - (prefix_sum[mid + 1])
                if need <= rem_new_flowers:
                    best_partial = target
                    l = mid + 1
                else:
                    r = mid - 1

            if best_partial == target:
                if n - num_full > 0:
                  best_partial = target
                else:
                  best_partial = 0
            else:
                if n - num_full > 0:
                  l, r = 0, n - num_full - 1
                  while l <= r:
                      mid = (l + r) // 2
                      need = (mid + 1) * target - (prefix_sum[mid + 1])
                      if need <= rem_new_flowers:
                          l = mid + 1
                      else:
                          r = mid - 1

                  if r >= 0:
                    best_partial = (prefix_sum[r+1] + rem_new_flowers) // (r+1)
                  else:
                    best_partial = 0
                  best_partial = min(target - 1, best_partial)
                else:
                  best_partial = 0

            ans = max(ans, num_full * full + best_partial * partial)

        return ans