class Solution:
    def getNumberOfBacklogOrders(self, orders: List[List[int]]) -> int:
        from collections import defaultdict
        import heapq

        buy_heap = []
        sell_heap = []

        for price, amount, order_type in orders:
            if order_type == 0:  # Buy order
                heapq.heappush(buy_heap, (-price, amount))
            else:  # Sell order
                heapq.heappush(sell_heap, (price, amount))

            while buy_heap and sell_heap:
                buy_price, buy_amount = buy_heap[0]
                sell_price, sell_amount = sell_heap[0]

                if -buy_price >= sell_price:  # Match orders
                    if buy_amount > sell_amount:
                        heapq.heappop(buy_heap)
                        heapq.heappush(buy_heap, (buy_price, buy_amount - sell_amount))
                        heapq.heappop(sell_heap)
                    elif buy_amount < sell_amount:
                        heapq.heappop(sell_heap)
                        heapq.heappush(sell_heap, (sell_price, sell_amount - buy_amount))
                        heapq.heappop(buy_heap)
                    else:
                        heapq.heappop(buy_heap)
                        heapq.heappop(sell_heap)
                else:
                    break

        total = 0
        for _, amount in buy_heap:
            total += amount
        for _, amount in sell_heap:
            total += amount

        return total % (10**9 + 7)