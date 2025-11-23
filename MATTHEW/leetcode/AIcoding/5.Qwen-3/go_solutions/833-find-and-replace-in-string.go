package main

func findReplaceString(s string, indices []int, sources []string, targets []string) string {
    // Create a slice of structs to hold the index, source, and target
    var operations []struct {
        index int
        src   string
        tgt   string
    }

    for i := range indices {
        operations = append(operations, struct {
            index int
            src   string
            tgt   string
        }{indices[i], sources[i], targets[i]})
    }

    // Sort the operations by index in descending order
    sort.Slice(operations, func(i, j int) bool {
        return operations[i].index > operations[j].index
    })

    // Process each operation
    for _, op := range operations {
        if len(s) >= op.index+len(op.src) && s[op.index:op.index+len(op.src)] == op.src {
            s = s[:op.index] + op.tgt + s[op.index+len(op.src):]
        }
    }

    return s
}