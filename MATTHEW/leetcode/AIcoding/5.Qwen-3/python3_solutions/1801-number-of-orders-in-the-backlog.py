from collections import deque
import heapq

class Solution:
    def numberofBacklogCards(self, orders: List[List[int]]) -> int:
        buy = []
        sell = []

        for price, amount, order_type in orders:
            if order_type == 0:
                while amount > 0 and sell and sell[0][0] <= price:
                    s_price, s_amount = heapq.heappop(sell)
                    if s_amount > amount:
                        s_amount -= amount
                        heapq.heappush(sell, (s_price, s_amount))
                        amount = 0
                    else:
                        amount -= s_amount
                if amount > 0:
                    heapq.heappush(buy, (-price, amount))
            else:
                while amount > 0 and buy and -buy[0][0] >= price:
                    b_price, b_amount = heapq.heappop(buy)
                    if b_amount > amount:
                        b_amount -= amount
                        heapq.heappush(buy, (b_price, b_amount))
                        amount = 0
                    else:
                        amount -= b_amount
                if amount > 0:
                    heapq.heappush(sell, (price, amount))

        total = 0
        for _, amount in buy:
            total += amount
        for _, amount in sell:
            total += amount
        return total % (10**9 + 7)