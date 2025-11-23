package main

func complexNumberMultiply(a string, b string) string {
    var real1, imag1, real2, imag2 int
    // Parse the first complex number
    _, _ = fmt.Sscanf(a, "%d+%di", &real1, &imag1)
    // Parse the second complex number
    _, _ = fmt.Sscanf(b, "%d+%di", &real2, &imag2)
    // Calculate the product
    real := real1*real2 - imag1*imag2
    imag := real1*imag2 + imag1*real2
    return fmt.Sprintf("%d+%di", real, imag)
}