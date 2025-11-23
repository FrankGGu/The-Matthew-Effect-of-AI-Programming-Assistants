package main

import (
	"container/list"
)

func countPaths(n int, edges [][]int) int64 {
	is_prime := make([]bool, n+1)
	// Sieve of Eratosthenes to find primes up to n
	for i := 2; i <= n; i++ {
		is_prime[i] = true
	}
	for p := 2; p*p <= n; p++ {
		if is_prime[p] {
			for i := p * p; i <= n; i += p {
				is_prime[i] = false
			}
		}
	}

	adj := make([][]int, n+1)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var total_valid_paths int64 = 0

	// Count paths consisting only of prime nodes
	visited_prime := make([]bool, n+1)
	for i := 1; i <= n; i++ {
		if is_prime[i] && !visited_prime[i] {
			count := 0
			q := list.New()
			q.PushBack(i)
			visited_prime[i] = true

			for q.Len() > 0 {
				curr := q.Remove(q.Front()).(int)
				count++

				for _, neighbor := range adj[curr] {
					if is_prime[neighbor] && !visited_prime[neighbor] {
						visited_prime[neighbor] = true
						q.PushBack(neighbor)
					}
				}
			}
			// Number of paths in a component of size 'count' is count * (count + 1) / 2
			total_valid_paths += int64(count) * int64(count+1) / 2
		}
	}

	// Count paths consisting only of composite nodes
	// Node 1 is neither prime nor composite, so it cannot be part of a valid path.
	// We only consider i > 1 for composite numbers.
	visited_composite := make([]bool, n+1)
	for i := 1; i <= n; i++ {
		// Check if i is composite and not yet visited
		if i > 1 && !is_prime[i] && !visited_composite[i] {
			count := 0
			q := list.New()
			q.PushBack(i)
			visited_composite[i] = true

			for q.Len() > 0 {
				curr := q.Remove(q.Front()).(int)
				count++

				for _, neighbor := range adj[curr] {
					// Check if neighbor is composite and not yet visited
					if neighbor > 1 && !is_prime[neighbor] && !visited_composite[neighbor] {
						visited_composite[neighbor] = true
						q.PushBack(neighbor)
					}
				}
			}
			total_valid_paths += int64(count) * int64(count+1) / 2
		}
	}

	return total_valid_paths
}