package main

func findOriginalString(encoded string) string {
    n := len(encoded)
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            result[i] = encoded[i/2]
        } else {
            result[i] = encoded[(i-1)/2]
        }
    }
    return string(result)
}