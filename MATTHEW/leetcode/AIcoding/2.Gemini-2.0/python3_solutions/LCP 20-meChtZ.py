import heapq

def solve():
  n, m = map(int, input().split())
  buses = []
  for _ in range(m):
    buses.append(list(map(int, input().split())))

  dist = [float('inf')] * (n + 1)
  dist[1] = 0
  pq = [(0, 1)]

  while pq:
    d, u = heapq.heappop(pq)

    if d > dist[u]:
      continue

    for bus in buses:
      s, f, c, t0 = bus
      if (u - 1) % s == 0:
        time = t0 + c * (u - 1) // s
        if time < dist[u]:
            continue

        cost = c

        v = f
        new_dist = time + cost + dist[u] - time

        if v <= n and new_dist < dist[v]:
          dist[v] = new_dist
          heapq.heappush(pq, (dist[v], v))

  if dist[n] == float('inf'):
    print(-1)
  else:
    print(dist[n])

solve()