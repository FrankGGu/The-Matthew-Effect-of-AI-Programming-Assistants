package main

import (
	"sort"
)

type DSU struct {
	parent []int
	size   []int // Used for union by size optimization
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}
	return &DSU{parent: parent, size: size}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) {
	rootI := d.find(i)
	rootJ := d.find(j)

	if rootI != rootJ {
		// Attach smaller tree under root of larger tree
		if d.size[rootI] < d.size[rootJ] {
			rootI, rootJ = rootJ, rootI // Swap to ensure rootI is the larger tree
		}
		d.parent[rootJ] = rootI
		d.size[rootI] += d.size[rootJ]
	}
}

func accountsMerge(accounts [][]string) [][]string {
	emailToIndex := make(map[string]int) // Maps email string to a unique integer ID
	emailToName := make(map[string]string) // Maps email string to the user's name
	var idxCounter int                     // Counter for assigning unique integer IDs to emails

	// First pass: Populate email maps
	// Assign a unique integer ID to each distinct email and store its associated name.
	for _, account := range accounts {
		name := account[0]
		for i := 1; i < len(account); i++ {
			email := account[i]
			if _, exists := emailToIndex[email]; !exists {
				emailToIndex[email] = idxCounter
				idxCounter++
			}
			emailToName[email] = name
		}
	}

	// Initialize DSU with the total number of unique emails found
	dsu := newDSU(idxCounter)

	// Second pass: Perform union operations based on shared emails within accounts
	for _, account := range accounts {
		// All emails in an account belong to the same person, so they should be merged.
		// We union all emails in an account with the first email of that account.
		firstEmail := account[1]
		firstEmailIdx := emailToIndex[firstEmail]
		for i := 2; i < len(account); i++ {
			email := account[i]
			emailIdx := emailToIndex[email]
			dsu.union(firstEmailIdx, emailIdx)
		}
	}

	// Third pass: Group emails by their root parent in the DSU structure
	// Each root parent represents a merged account.
	mergedEmails := make(map[int][]string) // Maps DSU root index to a list of emails
	for email, emailIdx := range emailToIndex {
		rootIdx := dsu.find(emailIdx)
		mergedEmails[rootIdx] = append(mergedEmails[rootIdx], email)
	}

	// Fourth pass: Format the results into the required output format
	var result [][]string
	for _, emails := range mergedEmails {
		sort.Strings(emails) // Sort emails alphabetically as per problem requirement

		// The name for the merged account can be retrieved from any email in the group,
		// as all emails in a merged account share the same original name.
		name := emailToName[emails[0]]

		// Prepend the name to the sorted list of emails
		accountResult := make([]string, len(emails)+1)
		accountResult[0] = name
		copy(accountResult[1:], emails)

		result = append(result, accountResult)
	}

	return result
}