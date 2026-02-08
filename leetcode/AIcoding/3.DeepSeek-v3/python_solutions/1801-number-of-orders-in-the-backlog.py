import heapq

class Solution:
    def getNumberOfBacklogOrders(self, orders: List[List[int]]) -> int:
        buy_heap = []  # max heap
        sell_heap = []  # min heap

        for price, amount, order_type in orders:
            if order_type == 0:  # buy order
                while amount > 0 and sell_heap and sell_heap[0][0] <= price:
                    sell_price, sell_amount = heapq.heappop(sell_heap)
                    if sell_amount > amount:
                        heapq.heappush(sell_heap, (sell_price, sell_amount - amount))
                        amount = 0
                    else:
                        amount -= sell_amount
                if amount > 0:
                    heapq.heappush(buy_heap, (-price, amount))
            else:  # sell order
                while amount > 0 and buy_heap and -buy_heap[0][0] >= price:
                    buy_price, buy_amount = heapq.heappop(buy_heap)
                    if buy_amount > amount:
                        heapq.heappush(buy_heap, (buy_price, buy_amount - amount))
                        amount = 0
                    else:
                        amount -= buy_amount
                if amount > 0:
                    heapq.heappush(sell_heap, (price, amount))

        total = 0
        for _, amount in buy_heap:
            total += amount
        for _, amount in sell_heap:
            total += amount
        return total % (10**9 + 7)