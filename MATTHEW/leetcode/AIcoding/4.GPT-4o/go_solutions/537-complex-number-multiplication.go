func complexNumberMultiply(a string, b string) string {
    var realA, imagA, realB, imagB int
    fmt.Sscanf(a, "%d+%di", &realA, &imagA)
    fmt.Sscanf(b, "%d+%di", &realB, &imagB)

    realResult := realA*realB - imagA*imagB
    imagResult := realA*imagB + imagA*realB

    return fmt.Sprintf("%d+%di", realResult, imagResult)
}